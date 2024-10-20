class PublicationsController < ApplicationController
  before_action :set_publication, only: %i[show edit update destroy apply]
  before_action only: [:new, :create, :edit, :update, :destroy] do
    authorize_request(["admin"])
  end
  before_action :authorize_normal_user, only: [:apply]

  # GET /publications or /publications.json
  def index
    @publications = Publication.all
  end

  # GET /publications/1 or /publications/1.json
  def show
    @publication = Publication.find(params[:id])
    @applicants = @publication.users
  end

  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit
  end

  # POST /publications or /publications.json
  def create
    @publication = Publication.new(publication_params)

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: "Publication was successfully created." }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: "Publication was successfully updated." }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @publication.destroy!

    respond_to do |format|
      format.html { redirect_to publications_path, status: :see_other, notice: "Publication was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # POST /publications/1/apply
  def apply
    if current_user.publications.include?(@publication)
      redirect_to @publication, alert: "Ya has postulado a esta publicación."
    else
      current_user.publications << @publication
      redirect_to @publication, notice: "Has postulado a esta publicación."
    end
  end

  private

  def set_publication
    @publication = Publication.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def publication_params
    params.require(:publication).permit(:cargo, :description)
  end

  def authorize_normal_user
    unless current_user&.role == 'normal_user'
      redirect_to publications_path, alert: "No tienes permiso para postularte a esta publicación."
    end
  end
end
