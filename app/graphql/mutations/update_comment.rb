module Mutations
  class UpdateComment < BaseMutation
    argument :input, Types::Inputs::UpdateCommentInput, required: true
    argument :id, ID, required: true

    type Types::Payloads::CommentPayload

    def resolve(input:,id:)
      input_params = input.to_h
      @comment = Comment.find_by(id: id)


        result = Comments::UpdateComment.call(comment: @comment,
          comment_attributes: input_params)


      result.to_h.merge(errors: formatted_errors(result.comment))

    end
  end
end
