for file in `cat list.txt`
do
    echo $file
    cd $file
    fslmaths insular-putamen/insular-putamen_fdt_paths_prob_max.nii.gz -mul putamen-insular/putamen-insular_fdt_paths_prob_max.nii.gz insular2putamen_fdt_paths_prob_max.nii.gz
    applywarp -i insular2putamen_fdt_paths_prob_max.nii.gz -o MNI-group_insular2putamen.nii.gz -r /opt/fsl/data/standard/MNI152_T1_2mm_brain.nii.gz --premat=/Users/mac/Desktop/structural_connect/DTI/$file/dti_FA_2T1.mat -w /Users/mac/Desktop/structural_connect/DTI/$file/T1_data_T1_2MNI152_warp.nii.gz --interp=nn
    cd ..
done
