function AnimalMetaData = DG_AnimalMetadataTextTemplate()

% This .m file is a generic template and will be copied to animal
% folders/session folders and will be called basename_AnimalMetadataText.m.
% It is represents code that will be used to
% create a basename.AnimalMetadata.mat file.  Edits here will be reflected
% in the .AnimalMetadata.mat created after this file is run.  
%
% INPUTS
%   basepath - computer path to folder where animal metadata is to go.
%   Often this is a path to an folder full of sessions all from one animal.
%
% OUTPUTS
%    AnimalMetadata and saved AnimalMetadata.mat
%       - Struct array containing fields including surgical info, animal
%       name, viruses injected, probes used etc.


AnimalMetaData.ID = input('Enter animal ID: ','s');
AnimalMetaData.Strain = input('Enter animal strain: ','s');
AnimalMetaData.Genotype = input('Enter animal genotype: ','s');
AnimalMetaData.Sex = input('Enter animal sex: ','s');
AnimalMetaData.DateOfBirth = input('Enter animal sex (YYYYMMDD format): ','s');
AnimalMetaData.Age = input('Enter animal age (days): ','s');

% Save
save('AnimalMetaData.mat','AnimalMetaData')

end
