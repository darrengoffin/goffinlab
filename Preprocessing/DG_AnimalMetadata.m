function AnimalMetadata = DG_AnimalMetadata()

% This is a generic template and will contain metadata for when animal underwent surgery

% The following require user input from the command line
AnimalMetadata.Animal.ID = input('Enter animal ID: ','s');
AnimalMetadata.Animal.Strain = input('Enter animal strain: ','s');
AnimalMetadata.Animal.Genotype = input('Enter animal genotype: ','s');
AnimalMetadata.Animal.Sex = input('Enter animal sex: ','s');
AnimalMetadata.Animal.DateOfBirth = input('Enter animal sex (YYYYMMDD format): ','s');
AnimalMetadata.Animal.Age = input('Enter animal age (days): ','s');

AnimalMetadata.Surgery.Date = input('Enter date of surgery (YYYYMMDD format): ','s');
AnimalMetadata.Surgery.Anesthesia.Name = input('Enter type of anesthesia: ','s');
AnimalMetadata.Surgery.Anesthesia.Concentration = input('Enter anesthesia concentration: ','s');

% The following require the user to update the struct file

AnimalMetadata.Probes.NumberOfProbes = input('Number of probes: ','s');
AnimalMetadata.Probes.TargetRegions = input('Target region (e.g. dCA1): ','s');
AnimalMetadata.Probes.TargetHemisphere = input('Target hemisphere (e.g. Left): ','s');
AnimalMetadata.Probes.ImplantCoordinates.Anteroposterior = input('Anteroposterior Coordinates (mm): ','s');
AnimalMetadata.Probes.ImplantCoordinates.Mediolateral = input('Mediolateral Coordinates (mm): ','s');
AnimalMetadata.Probes.ImplantAngle.Anteroposterior = input('Anteroposterior Angle: ','s');
AnimalMetadata.Probes.ImplantAngle.Mediolateral = input('Mediolateral Angle: ','s');
AnimalMetadata.Probes.ImplantCoordinates.DepthFromSurface = input('Depth from surface (mm): ','s');
AnimalMetadata.Probes.ProbeType = input('Type of probe (e.g. NRX_A1x16): ','s'); %filenames in /goffinlab/...

% Save
save('AnimalMetadata.mat','AnimalMetadata')

end
