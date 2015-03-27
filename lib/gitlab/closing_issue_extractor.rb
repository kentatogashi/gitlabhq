module Gitlab
  module ClosingIssueExtractor
    ISSUE_CLOSING_REGEX = Regexp.new(Gitlab.config.gitlab.issue_closing_pattern)

    def self.closed_by_message_in_project(message, project)
      issues = []

      unless message.nil?
        md = message.scan(ISSUE_CLOSING_REGEX)

        md.each do |ref|
          extractor = Gitlab::ReferenceExtractor.new(project)
          extractor.analyze(ref[0])
          issues += extractor.issues
        end
      end

      issues.uniq
    end
  end
end
