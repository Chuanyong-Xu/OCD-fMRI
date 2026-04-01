# this is just another algorithm for "step2_statistic_in_dtispace", you can select this or not
for file in `cat list.txt`
do
    echo $file
    cd $file
    fslstats /mnt/data/guangzhounaokeyuan_data/Structural_connection_guangzhounaokeyuan-Kangning/DTI/$file/ROIdti_ACC_AAL90.nii.gz -V > ACC-caudate/ACC_voxel_number.txt
    VAR=`awk '{print $1}' ACC-caudate/ACC_voxel_number.txt`
    fslmaths ACC-caudate/fdt_paths.nii.gz -div $VAR -div 5000 ACC-caudate/ACC-caudate_fdt_paths_standard.nii.gz
    fslmaths ACC-caudate/ACC-caudate_fdt_paths_standard.nii.gz -thr 0.05 -bin ACC-caudate/ACC-caudate_fdt_paths_standard_mask_05.nii.gz

    fslstats /mnt/data/guangzhounaokeyuan_data/Structural_connection_guangzhounaokeyuan-Kangning/DTI/$file/ROIdti_caudate.nii.gz -V > caudate-ACC/caudate_voxel_number.txt
    VAR1=`awk '{print $1}' caudate-ACC/caudate_voxel_number.txt`
    fslmaths caudate-ACC/fdt_paths.nii.gz -div $VAR1 -div 5000 caudate-ACC/caudate-ACC_fdt_paths_standard.nii.gz
    fslmaths caudate-ACC/caudate-ACC_fdt_paths_standard.nii.gz -thr 0.05 -bin caudate-ACC/caudate-ACC_fdt_paths_standard_mask_05.nii.gz

    fslmaths caudate-ACC/caudate-ACC_fdt_paths_standard_mask_05.nii.gz -mul ACC-caudate/ACC-caudate_fdt_paths_standard_mask_05.nii.gz caudate2ACC_fdt_paths_standard_mask_05.nii.gz
    cd ..
done
