module Steps
  module AbuseConcerns
    class QuestionController < Steps::AbuseConcernsStepController
      def edit
        @form_object = QuestionForm.new(
          c100_application: current_c100_application,
          subject: current_concern.subject,
          kind: current_concern.kind,
          answer: current_concern.answer
        )
      end

      def update
        update_and_advance(QuestionForm, as: :question)
      end

      private

      def subject_value
        AbuseSubject.new(params.fetch(:subject, AbuseSubject::APPLICANT.to_s))
      end

      def kind_value
        AbuseType.new(params.fetch(:kind, AbuseType::SUBSTANCES.to_s))
      end

      def current_concern
        @_current_concern ||= current_c100_application.abuse_concerns.find_or_initialize_by(
          subject: subject_value,
          kind: kind_value
        )
      end
    end
  end
end