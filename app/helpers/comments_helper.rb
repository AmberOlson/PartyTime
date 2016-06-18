module CommentsHelper
  def comment_email_or_name(comment, user)
     if comment.user.name.nil?
       comment.user.email
    else
      comment.user.name
    end
  end
end
