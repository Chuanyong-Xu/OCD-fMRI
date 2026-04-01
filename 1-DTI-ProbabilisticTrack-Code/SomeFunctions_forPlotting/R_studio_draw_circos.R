# 准备数据文件：在matlab中准备好数据矩阵文件N*N，取矩阵下三角部分，将邻接矩阵转三列矩阵文件，存为.csv格式,如：test.csv
# 准备弦图sector颜色信息文件：单独建立一个.csv文件，根据原始N*N矩阵的行/列数，在这个csv文件第一列输入相应的颜色名称（若为38*38的矩阵，则输入38行*1列的颜色名称），保存。
#library('circlize')
#data<-read.csv('E:/data/KN/3_HC73_MD62_OCD50/4_FC_VBM_Fiber_hc45_md49_ocd41_ROI_wise/4_Results-FC_network_FunARCWSFB/NBS_HC_OCD/test.csv',header = TRUE,stringsAsFactors = FALSE)
#View(data)
#sector<-read.csv('E:/data/KN/3_HC73_MD62_OCD50/4_FC_VBM_Fiber_hc45_md49_ocd41_ROI_wise/4_Results-FC_network_FunARCWSFB/NBS_HC_OCD/sector.csv',header = FALSE,stringsAsFactors = FALSE)
#sector<-as.vector(sector$V1)
#View(sector)
#circos.par(start.degree = 120,gap.degree = 1)
#chordDiagram(data,grid.col = sector,annotationTrack = c("name","grid"),col = 'green')

#############################
#参考网址：https://cloud.tencent.com/developer/article/1431215
#############################
circos.clear()
#导入数据需要提前筛选，将第三列中，数值为0的行删除；并删去元素的''符号、删去表标题
library('circlize')
data<-read.csv('E:/data/KN/3_HC73_MD62_OCD50/4_FC_VBM_Fiber_hc45_md49_ocd41_ROI_wise/4_Results-FC_network_FunARCWSFB/NBS_HC_OCD/test.csv',header = FALSE,stringsAsFactors = FALSE)
View(data)
#导入外圈sector变量
sector<-read.csv('E:/data/KN/3_HC73_MD62_OCD50/4_FC_VBM_Fiber_hc45_md49_ocd41_ROI_wise/4_Results-FC_network_FunARCWSFB/NBS_HC_OCD/sector.csv',header = FALSE,stringsAsFactors = FALSE)
sector<-as.vector(sector)
View(sector)
#画布大小设定
circos.par(canvas.xlim=c(-1.2,1.2),canvas.ylim=c(-1.2,1.2),cell.padding=c(0.02,0,0.02,0))
#设定外圈sector所涉及的变量
fa=sector$V3
fa=factor(fa,levels = fa)
#画布
circos.initialize(factors = fa,xlim =c(0,1) )
#画最外圈
#设定外圈sector的颜色-渐变
col_fun=colorRamp2(c(1,19,31),c("blue","black","red"))
#画外圈轨道参数
circos.trackPlotRegion(
  ylim=c(0,1),track.height = 0.15,bg.border = 'black',bg.col = col_fun(sector$V2),
  panel.fun = function(x,y){
    sector.index=get.cell.meta.data('sector.index')
    xlim=get.cell.meta.data('xlim')
    ylim=get.cell.meta.data('ylim')
  })
#给外圈sector贴标签
for (i in 1:nrow(sector)){
  circos.axis(sector.index = sector[i,3],direction = "outside",labels = sector[i,3],
              labels.facing = "clockwise",labels.cex = 0.58,col='black',
              labels.away.percentage = 0.1,minor.ticks = 0,major.at = seq(1,length(sector$V3)))
}
#画第二圈（内圈）
circos.trackPlotRegion(
  ylim=c(0,1),track.height = 0.15,bg.border =NA,
  panel.fun = function(x,y){
    sector.index=get.cell.meta.data('sector.index')
    xlim=get.cell.meta.data('xlim')
    ylim=get.cell.meta.data('ylim')
  })
#给第二圈命名及颜色等参数设定，network
highlight.sector(as.character(sector$V3[1:18]),track.index = 2,
                 text='Goal directed',niceFacing=T,font=2,col='#CCEBC5')
highlight.sector(as.character(sector$V3[19:30]),track.index = 2,
                 text='Habitual',niceFacing=F,font=2,col='#FFCC99')
highlight.sector(as.character(sector$V3[31:38]),track.index = 2,
                 text='Reward',niceFacing=T,font=2,col='#CCCCff')

#画连边(注意point起点的宽度应为1，才能争取落在起点上)
for (i in 1:nrow(data)){
circos.link(sector.index1 = data[i,1],point1 = 1,sector.index2 = data[i,2],point2 = 1,
            h=0.5,lwd=3,col="#FFCC99",lty=1)}
circos.clear()

  
  