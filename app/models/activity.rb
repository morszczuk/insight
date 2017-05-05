class Activity < ApplicationRecord
    has_many :laps
    has_many :lap_summaries, through: :laps

    has_attached_file :gpx
    validates_attachment_file_name :gpx, :matches => [/gpx\Z/, /xml\Z/]
    before_save :parse_file

    def parse_file
        tempfile = gpx.queued_for_write[:original]
        doc = Nokogiri::XML(tempfile)
        parse_xml(doc)
    end 

    private

    def parse_xml(doc)
        doc.root.elements.each do |node|
            parse_activities(node) if node.node_name.eql? "Activities"    
        end
    end

    def parse_activities(activities)
        activities.elements.each do |node|
            parse_activity(node) if node.node_name.eql? "Activity"   
        end 
    end

    def parse_activity(activity)
        self.sport = activity.attr('Sport')
        activity.elements.each do |node|
            parse_activity_id(node) if node.node_name.eql? "Id"
            self.laps << parse_lap(node) if node.node_name.eql? "Lap"
        end
    end    

    def parse_activity_id(activity_id)
        self.activity_id = DateTime.parse(activity_id.text.to_s)
    end

    def parse_lap(lap)
        lap_summary = parse_lap_summary(lap)
        Lap.new(
            start_time: parse_lap_start_time(lap.attr('StartTime')),
            lap_summary: lap_summary
        )
    end

    def parse_lap_summary(lap)
        lap_summary = LapSummary.new
        lap.elements.each do |node|
            lap_summary.total_time_seconds = node.text.to_f if node.node_name.eql? "TotalTimeSeconds"
            lap_summary.distance_meters = node.text.to_f if node.node_name.eql? "DistanceMeters"
            lap_summary.maximum_speed = node.text.to_f if node.node_name.eql? "MaximumSpeed"
            lap_summary.calories = node.text.to_f if node.node_name.eql? "Calories"
            lap_summary.average_heart_rate_bmp = node.elements.first.text.to_i if node.node_name.eql? "AverageHeartRateBmp"
            lap_summary.maximum_heart_rate_bmp = node.elements.first.text.to_i if node.node_name.eql? "MaximumHeartRateBmp"
            lap_summary.intensity = node.text.to_s if node.node_name.eql? "Intensity"
            lap_summary.cadence = node.text.to_i if node.node_name.eql? "Cadence"
            lap_summary.trigger_method = node.text.to_s if node.node_name.eql? "TriggerMethod"
        end
        lap_summary
    end

    def parse_lap_start_time(start_time_data)
        DateTime.parse(start_time_data)
    end
end
