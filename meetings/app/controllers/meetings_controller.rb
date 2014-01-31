class MeetingsController < ApplicationController
  unloadable

  helper :attachments
  include AttachmentsHelper

  helper :meetings
  include MeetingsHelper

  User.send(:include, UserPatch)
  before_filter :authorize, :only => [:create]

  def index
    @meetings = Meeting.find(:all, :order => "start DESC")
  end

  def show
    @meeting = Meeting.find(params[:id])
    render "show"
  end

  # Обрабатывает и POST и GET
  def create
    # POST запрос - обрабатываем форму
    if request.post?
      @meeting = Meeting.new
      @meeting.topic = params[:meeting][:topic]
      @meeting.location = params[:meeting][:location]
      @meeting.description = params[:meeting][:description]
      @meeting.start = params[:meeting][:start]
      @meeting.end = params[:meeting][:end]
      @meeting.results = params[:meeting][:results]
      params[:meeting][:users].each do |item|
        if !item.blank?
          user = User.find(item)
          @meeting.users << user
        end
      end

      #@meeting.save_attachments(params[:attachments] || params[:meeting] && params[:meeting][:uploads])
      if @meeting.save
        respond_to do |format|
          format.html {
            render_attachment_warning_if_needed(@meeting)
            flash[:notice] = l(:notice_meeting_successful_create,
                             :id => view_context.link_to("##{@meeting.id}", meetings_path(@meeting.id), :id => @meeting.id, :title => @meeting.topic))
          }
          format.api  { render :action => 'show' }
        end
        redirect_to :action => 'index'
      else
        respond_to do |format|
          format.html { render :action => 'create', :method => 'get' }
          format.api  { render_validation_errors(@meeting) }
        end
      end
    # GET запрос - рендерим представление create
    else
      @meeting = Meeting.new
    end
  end

end
