for file in `cat list.txt`
do
  echo $file
#ROI transformation（volume-based）
  dti_dir=/mnt/FLICA_GZ/1DTI/DTI1_preprocessed/$file
  t1_dir=/mnt/FLICA_GZ/2T1/T11_Raw/T1_bet/$file
  #flirt -in $dti_dir/dti_FA.nii.gz -ref $t1_dir/T1_data_brain.nii.gz -cost corratio -dof 12 -omat $dti_dir/dti_FA_2T1.mat
#
  #convert_xfm -omat $dti_dir/dti_T1_2FA.mat -inverse $dti_dir/dti_FA_2T1.mat
#
  #fsl_reg $t1_dir/T1_data_brain.nii.gz $FSLDIR/data/standard/MNI152_T1_2mm_brain.nii.gz $dti_dir/dti_T1_2MNI152
#
  #invwarp -w $dti_dir/dti_T1_2MNI152_warp.nii.gz -r $t1_dir/T1_data_brain.nii.gz -o $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz
#ROI_sphere transform
  roi_dir1=/mnt/FLICA_GZ/1DTI/ProbTrack_20220406/ROI
  applywarp -i $roi_dir1/Caudate_L.nii.gz -o $dti_dir/dti_Caudate_L.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir1/Caudate_R.nii.gz -o $dti_dir/dti_Caudate_R.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir1/NAC_L.nii.gz -o $dti_dir/dti_NAC_L.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir1/NAC_R.nii.gz -o $dti_dir/dti_NAC_R.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir1/Putamen_L.nii.gz -o $dti_dir/dti_Putamen_L.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir1/Putamen_R.nii.gz -o $dti_dir/dti_Putamen_R.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn

#ROI_striatum_structural_2mm transfrom
  roi_dir2=/mnt/FLICA_GZ/1DTI/ProbTrack_20220406/ROI_striatum_structural_2mm
  applywarp -i $roi_dir2/Caudate_L2.nii.gz -o $dti_dir/dti_Caudate_L2.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/Caudate_R2.nii.gz -o $dti_dir/dti_Caudate_R2.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/NAC_L2.nii.gz -o $dti_dir/dti_NAC_L2.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/NAC_R2.nii.gz -o $dti_dir/dti_NAC_R2.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/Putamen_L2.nii.gz -o $dti_dir/dti_Putamen_L2.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/Putamen_R2.nii.gz -o $dti_dir/dti_Putamen_R2.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn

  applywarp -i $roi_dir2/Caudate_L2_ExcludMask.nii.gz -o $dti_dir/dti_Caudate_L2_ExcludMask.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/Caudate_R2_ExcludMask.nii.gz -o $dti_dir/dti_Caudate_R2_ExcludMask.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/NAC_L2_ExcludMask.nii.gz -o $dti_dir/dti_NAC_L2_ExcludMask.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/NAC_R2_ExcludMask.nii.gz -o $dti_dir/dti_NAC_R2_ExcludMask.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/Putamen_L2_ExcludMask.nii.gz -o $dti_dir/dti_Putamen_L2_ExcludMask.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn
  applywarp -i $roi_dir2/Putamen_R2_ExcludMask.nii.gz -o $dti_dir/dti_Putamen_R2_ExcludMask.nii.gz -r $dti_dir/dti_FA.nii.gz -w $dti_dir/dti_T1_2MNI152_warp_inv.nii.gz --postmat=$dti_dir/dti_T1_2FA.mat --interp=nn

#Probabilistic tractography (probtrack2, volume-based)
  bedpostx_dir=/mnt/FLICA_GZ/1DTI/bedpostX_done/$file.bedpostX
#1) Fiber tracking  from, sphere ROI
  probtrackx2  -x $dti_dir/dti_Caudate_L.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir1/$file/Caudate_L
  probtrackx2  -x $dti_dir/dti_Caudate_R.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir1/$file/Caudate_R

  probtrackx2  -x $dti_dir/dti_NAC_L.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir1/$file/NAC_L
  probtrackx2  -x $dti_dir/dti_NAC_R.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir1/$file/NAC_R

  probtrackx2  -x $dti_dir/dti_Putamen_L.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir1/$file/Putamen_L
  probtrackx2  -x $dti_dir/dti_Putamen_R.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir1/$file/Putamen_R

#2) Fiber tracking  from, striatum_structural_2mm ROI
  #probtrackx2  -x $dti_dir/dti_Caudate_L2.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --avoid=$dti_dir/dti_Caudate_L2_ExcludMask.nii.gz --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir2/$file/Caudate_L2
  probtrackx2  -x $dti_dir/dti_Caudate_L2.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir2/$file/Caudate_L2
  probtrackx2  -x $dti_dir/dti_Caudate_R2.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir2/$file/Caudate_R2

  probtrackx2  -x $dti_dir/dti_NAC_L2.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir2/$file/NAC_L2
  probtrackx2  -x $dti_dir/dti_NAC_R2.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir2/$file/NAC_R2

  probtrackx2  -x $dti_dir/dti_Putamen_L2.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir2/$file/Putamen_L2
  probtrackx2  -x $dti_dir/dti_Putamen_R2.nii.gz  -l --onewaycondition -c 0.2 -S 2000 --steplength=0.5 -P 5000 --fibthresh=0.01 --distthresh=0.0 --sampvox=0.0 --forcedir --opd -s $bedpostx_dir/merged -m $bedpostx_dir/nodif_brain_mask  --dir=$roi_dir2/$file/Putamen_R2

done
