for file in `cat list.txt`
do
    echo $file
    cd $file
    fslstats /mnt/data/guangzhounaokeyuan_data/Structural_connection_guangzhounaokeyuan-Kangning/DTI/$file/dti_FA.nii.gz -k NA2ACC_fdt_paths_prob_max_mask_05.nii.gz -M >> /mnt/data/guangzhounaokeyuan_data/Structural_connection_guangzhounaokeyuan-Kangning/results_AAL90_32-30-32/NA2ACC-FA_05thr.txt # extract the FA value in overlapped fiber path mask

    applywarp -i NA2ACC_fdt_paths_prob_max_mask_05.nii.gz -o MNI_NA2ACC_05.nii.gz -r /opt/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz --premat=/mnt/data/guangzhounaokeyuan_data/Structural_connection_guangzhounaokeyuan-Kangning/DTI/$file/dti_FA_2T1.mat -w /mnt/data/guangzhounaokeyuan_data/Structural_connection_guangzhounaokeyuan-Kangning/DTI/$file/T1_data_T1_2MNI152_warp.nii.gz --interp=nn # for visualization in MNI sapce
    cd ..
done
