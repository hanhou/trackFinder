# trackFinder
Electrode track localization tool

The warping of the 3D electrode track image to the Allen Institute Common Coordinate Framework (CCF) is done in BigWarp in ImageJ.

After warping the electrode track image into the CCF, the electrode track is then traced in the CCF by placing landmarks along the track.

The electode track in CCF is warped to the MRI atlas to assign electrode sites based on physical distance.

Finally, the electorde sites are transformed to CCF coordinates.

MRI atlas and downsampled Allen Anatomical Template (AAT) can be found here, https://www.dropbox.com/sh/i68qb8m4hmd3pf1/AACeBoskNOWkeZAo5Uf3JGaza?dl=0

Example data can be found here, https://www.dropbox.com/sh/qjj6ej3ecyz8xpx/AACjDwuxV86TSiC2Vd_3BRMia?dl=0
