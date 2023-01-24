library(tidyverse)

my_theme <- function() {
  theme_minimal(base_family = "Helvetica") +
    theme(title = element_text(size = 8),
          panel.border = element_blank(),
          panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(), 
          plot.margin = unit(c(0.21, 0.21, 0.21, 0.21), "lines"),
          axis.line = element_line(colour = "grey20"), 
          axis.text = element_text(size = 8),
          axis.title = element_text(size = 8),
          axis.title.y = element_text(angle = 90),
          legend.key = element_blank(), 
          legend.key.size = unit(0.25, "cm"),
          legend.margin = margin(0.5, 0.5, 0.5, 0.5),
          legend.text = element_text(size = 8),
          strip.text = element_text(size = 8),
          #strip.background = element_rect(fill = "white", colour = "black", size = 1),
          strip.background = element_blank(), 
          panel.background = element_blank(),
          complete = TRUE)
} 

##Main## 
args <- commandArgs(trailingOnly=TRUE)  
input1 <- args[1] 
gene <- args[2]

D <- read_tsv(input1, show_col_types = FALSE)
min(D$TPM)
D1m <- D %>% mutate(TPM2 = case_when(
  TPM < 10^-2 ~ as.numeric(10^-2),
  TPM >= 10^-2 ~ as.numeric(TPM)))

p1 <- ggplot(D1m, aes(x=Cancer_type, y=log10(TPM2), fill="white")) + geom_boxplot(outlier.shape = NA, alpha=0.8, fill="white") +
  geom_point(position=position_jitterdodge(), size = 0.3 ,alpha=0.4, colour = "#fc4e2a") +
  scale_y_continuous(limits=c(-2,4.5), breaks = seq(-2, 4, 1)) +
  labs(y = "TPM (log)", x = "Cancer type") +
  ggtitle(paste(gene,"/MS2",collapse=" ")) +
  my_theme() + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5),
        axis.title.y = element_text(hjust = 0.5, vjust = 1),
        legend.position = "none") 
  #geom_hline(yintercept = log10(0.1), color = "grey")
#plot(p1)
ggsave(paste("./output/figure/MS2_tpm_",gene,".pdf",sep=""), width = 12, height = 8, units = "cm")

