# trackFinder
Electrode track localization tool

The warping of the 3D electrode track image to the Allen Institute Common Coordinate Framework (CCF) is done in BigWarp in ImageJ.

After warping the electrode track image into the CCF, the electrode track is then traced in the CCF by placing landmarks along the track. This generates a .csv file from BigWarp which is the first input of the TrackFinder.m function.

The electode track in CCF is warped to the MRI atlas to assign electrode sites based on physical distance when running trackFinder.m. The inputs are name of the .csv file, MRI landmarks, probe landmarks, variable to save the output or not.
If the MRI landmarks and probe landmarks are the same, then just plotting the warped line without. e.g.
siteShort=trackFinder('H:\a3d\SC030\landmarks_100219_LMed.csv',[1 2], [1 2], 0);

When scaling using electrophysiological landmarks, run trackFinder.m again with the landmarks. The landmark inputs are in electrode numbers. Note the most ventral electrode on the probe is 384. The last input is saving and overwriting the results. e.g.
site2=trackFinder('H:\a3d\SC030\landmarks_100219_LMed.csv',[0 231], [-165 135], 1);

Finally, in the ouput, the electorde sites are transformed to CCF coordinates.

MRI atlas and downsampled Allen Anatomical Template (AAT) can be found here, https://www.dropbox.com/sh/i68qb8m4hmd3pf1/AACeBoskNOWkeZAo5Uf3JGaza?dl=0

Example data can be found here, https://www.dropbox.com/sh/qjj6ej3ecyz8xpx/AACjDwuxV86TSiC2Vd_3BRMia?dl=0
