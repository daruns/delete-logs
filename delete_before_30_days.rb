require "date"
LOG_FILE_PATH ||= "/var/log/bngs/"
DATE_REGEX ||= /(?<year>[0-9]{4})-(?<month>[0-9]{2})-(?<day>[0-9]{2})/

now_day = Time.now.strftime("%Y-%m-%d")
yesterday_file_log = Dir[LOG_FILE_PATH + "*"]
if yesterday_file_log.count
  yesterday_file = yesterday_file_log.map {|s| s.match(DATE_REGEX).to_s } - ["", nil]
  yesterday_file_log = yesterday_file_log - yesterday_file.map {|s| "#{LOG_FILE_PATH}#{s}" if ((Date.parse(now_day) - Date.parse(s)) < 90) }
  yesterday_file_log.each do |s|
    p "deleted --------  #{s}"
    system "rm -r #{s}"
  end
end

