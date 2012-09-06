load("uri-lt-data.RData")
library(Distance)
library(ggplot2)
library(dsm)


p.opts.geo <- opts(panel.grid.major=theme_blank(),
                   panel.grid.minor=theme_blank(),
                   panel.background=theme_blank(),
                   strip.background=theme_blank(),
                   legend.key=theme_blank(),
                   axis.ticks=theme_blank(),
                   axis.text.x=theme_blank(),
                   axis.text.y=theme_blank(),
                   axis.title.x=theme_blank(),
                   axis.title.y=theme_blank(),
                   axis.ticks.margin=unit(0,"npc"),
                   axis.ticks.length=unit(0,"npc"),
                   aspect.ratio=1,
                   plot.margin = unit(c(0.5,0,-1,1), "lines")
                  )
coord <- coord_cartesian(xlim = c(-40,40),ylim = c(-40,40))

pred$width <- rep(2,nrow(pred))
pred$height <- rep(2, nrow(pred))

# make a copy of pred and call the response "resp"
cpred <- pred

cnames <- names(pred)
cnames <- c("roughness","phimedian","distancelandkm","chl_fall","chl_winter",
            "chl_spring","chl_summer","depthm","slope")

for(this.name in cnames){

  cpred$resp <- cpred[,this.name]

  p <- ggplot(cpred)
  p <- p + coord + p.opts.geo
  p <- p + geom_tile(aes(x=x,y=y,fill=resp, height=height, width=width))
  p <- p + geom_polygon(aes(x=x,y=y,group=group),
                                 colour=NA,data=coast)
  p <- p + labs(fill=this.name)
  print(p)
  
  #quartz()

  ggsave(paste("covar-",this.name,".pdf",sep=""),width=8,height=8)

}





