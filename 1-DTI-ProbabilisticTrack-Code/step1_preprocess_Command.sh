#1.1 DTI and TI image format conversion
for file in `cat list.txt`
do
    echo $file
    cd $file
    mkdir DWI/
    mv *.dcm DWI/
    dcm2nii DWI #1.1 DTI image format conversion; for T1 image conversion, just use the same comman in T1-data-folder/
    cd DWI
    mv 2*.nii.gz DWI.nii.gz
    mv 2*.bval bvals.bval
    mv 2*.bvec bvecs.bvec
    mv DWI.nii.gz ../
    mv bvals.bval ../
    mv bvecs.bvec ../
    cd ..
    #1.2 Checking the quality of data
    eddy_correct DWI.nii.gz data.nii.gz 0 #1.3 Eddy current
    fdt_rotate_bvecs bvecs.bvec eddy_bvecs.bvec data.ecclog #1.4 Rotating the gradients 
    fslroi data.nii.gz b0 0 1 #1.5 Creating the mask for the later procedure
    bet2 b0 b0_brain -f 0.25 -m #1.6 Bet DTI image (the parameter depended on the quality after betting, T1 bet using the same command)
    mv b0_brain_mask.nii.gz nodif_brain_mask.nii.gz # rename for bedpostX
    dtifit -k data.nii.gz -m nodif_brain_mask.nii.gz -r eddy_bvecs.bvec -b bvals.bval -o dti #1.7 Calculating the diffusion tensor (DTIFIT)
    mv eddy_bvecs.bvec bvecs  # rename for bedpostX
    mv bvals.bval bvals  # rename for bedpostX
    mv dti_L1.nii.gz dti_AD.nii.gz
    fslmaths dti_L2.nii.gz -add dti_L3.nii.gz -div 2 dti_RD.nii.gz
    cd ..
done

#1.8 Estimating the direction distribution (bedpostX , using the default parameters, the files you need prepared: data.nii.gz, bvecs, bvals, nodif_brain_mask.nii.gz, dti_FA.nii.gz). This step need a lot of time:(1)you can use parallel processing; (2)or use the GPU to accelerate, details in FSL website (3) PANDA toolbox in matlab
bedpostx each-subject-folder-name/ --nf=2 --fudge=1  --bi=1000 # single subject each time

apt install parallel # or parallel processing (installing)
export OMP_NUM_THREADS=2 # or parallel processing (number of workers for parallel)
parallel -j 2 bedpostx {} ::: sub_ocd272 sub_ocd273 2>&1 | tee log.txt # or parallel processing

bedpostx_gpu each-subject-folder-name/ # or GPU to accelerate

#1.9 ROI transformation（volume-based）, for preparing the files that will be used in fiber tracking
flirt -in DTI/Control_9002/dti_FA.nii.gz -ref T1/Control_9002/T1_data_brain.nii.gz -cost corratio -dof 12 -omat DTI/Control_9002/dti_FA_2T1.mat
convert_xfm -omat DTI/Control_9002/dti_T1_2FA.mat -inverse DTI/Control_9002/dti_FA_2T1.mat
fsl_reg_T1/Control_9002/T1_data_brain.nii.gz $FSLDIR/data/standard/MNI152_T1_2mm_brain.nii.gz DTI/Control_9002/dti_T1_2MNI152
invwarp -w DTI/Control_9002/dti_T1_2MNI152_warp.nii.gz -r T1/Control_9002/T1_data_brain.nii.gz -o DTI/Control_9002/dti_T1_2MNI152_warp_inv.nii.gz
applywarp -i caudate.nii.gz -o DTI/Control_9002/dti_caudate.nii.gz -r DTI/Control_9002/dti_FA.nii.gz -w DTI/Control_9002/dti_T1_2MNI152_warp_inv.nii.gz --postmat=DTI/Control_9002/dti_T1_2FA.mat --interp=nn

#1.10 Probabilistic tractography (probtrack2, volume-based)
#1) Fiber tracking  from caudate to dlPFC
probtrackx2  -x ROIdti_caudate.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --stop=ROIdti_dlPFC_AAL90.nii.gz --forcedir --opd -s /media/xcy/000988C50005D638/XCY/structural_connect/probatrack/bedpostX/$file.bedpostX/merged -m /media/xcy/000988C50005D638/XCY/structural_connect/probatrack/bedpostX/$file.bedpostX/nodif_brain_mask  --dir=/media/xcy/000988C50005D638/XCY/structural_connect/probatrack/results_AAL90/$file/caudate-dlPFC --waypoints=ROIdti_dlPFC_AAL90.nii.gz --waycond=AND
#2) Fiber tracking from dlPFC to caudate
probtrackx2  -x ROIdti_dlPFC_AAL90.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --stop=ROIdti_caudate.nii.gz --forcedir --opd -s /media/xcy/000988C50005D638/XCY/structural_connect/probatrack/bedpostX/$file.bedpostX/merged -m /media/xcy/000988C50005D638/XCY/structural_connect/probatrack/bedpostX/$file.bedpostX/nodif_brain_mask  --dir=/media/xcy/000988C50005D638/XCY/structural_connect/probatrack/results_AAL90/$file/dlPFC-caudate --waypoints=ROIdti_caudate.nii.gz --waycond=AND

#1.11 statistic, you have many ways can complete this. See the detailed bash files.
