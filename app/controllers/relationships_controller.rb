class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @classifications = [{:id => "classification_other", :class => "classification_other", :title => "Other:", :classification => Relationship::REL_OTHER},
                        {:id => "classification_friend", :class => "classification_friend", :title => "Friend:", :classification => Relationship::REL_FRIEND},
                        {:id => "classification_family", :class => "classification_family", :title => "Family:", :classification => Relationship::REL_FAMILY},
                        {:id => "classification_school", :class => "classification_school", :title => "School:", :classification => Relationship::REL_SCHOOL},
                        {:id => "classification_coworker", :class => "classification_coworker", :title => "Coworker:", :classification => Relationship::REL_COWORKER}
]
    @user = current_user
    @relationships = Relationship.where(:user_id => @user.id)
  end

  def update
    classification_update = params[:classification]

    activated_ids = params[:activated].keys if params[:activated]

    activated_ids.each do |id|
      r = Relationship.find_by_id(id)
      r.update_attribute(:classification, classification_update)
      r.save
    end
    redirect_to edit_relationship_path
  end


end
