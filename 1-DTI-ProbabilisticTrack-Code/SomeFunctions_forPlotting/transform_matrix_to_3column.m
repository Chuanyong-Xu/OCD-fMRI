clc
clear all
a=load('Edge_Pos_Comnet_P=0.048951.txt');
roi={'1L_caudate,2L','dACC','3L_dlPFC','4L_dmPFC','5L_IFG','6L_IPG','7L_OFC','8L_supACC','9L_vlPFC','10R_caudate','11R_dACC','12R_dlPFC','13R_dmPFC','14R_IF','15R_IPG','16R_OFC','17R_supACC','18R_vlPFC','19L_insula','20L_MTG','21L_poCG','22L_preCG','23L_putamen','24L_SMA','25R_insula','26R_MTG','27R_poCG','28R_preCG','29R_putamen','30R_SMA','31L_NAcc','32L_preACC','33L_subACC','34L_vmPFC','35R_NAcc','36R_preACC','37R_subACC','38R_vmPFC'};
t=0;
for i=1:37;
for j=(i+1):38;
    t=t+1;
    result{t,1}=roi(i);
    result{t,2}=roi(j);
    result{t,3}=a(i,j);
end
end