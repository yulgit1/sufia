require "psu-customizations"

class GenericFile < ActiveFedora::Base
  include Hydra::ModelMixins::CommonMetadata
  include Hydra::ModelMethods

  has_metadata :name => "characterization", :type => FitsDatastream
  has_metadata :name => "descMetadata", :type => ActiveFedora::DCRDFDatastream
  has_file_datastream :type => FileContentDatastream

  delegate :contributor, :to => :descMetadata
  delegate :creator, :to => :descMetadata
  delegate :title, :to => :descMetadata
  delegate :description, :to => :descMetadata
  delegate :publisher, :to => :descMetadata
  delegate :created, :to => :descMetadata
  delegate :subject, :to => :descMetadata
  delegate :language, :to => :descMetadata
  delegate :date, :to => :descMetadata
  delegate :rights, :to => :descMetadata
  delegate :type, :to => :descMetadata
  delegate :format, :to => :descMetadata
  delegate :identifier, :to => :descMetadata

  before_save :characterize

  ## Extract the metadata from the content datastream and record it in the characterization datastream
  def characterize
    if content.changed?
      characterization.content = content.extract_metadata
    end
  end
end