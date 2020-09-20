library(tidyverse)

read_delim("../Desktop/pot_test/Min12.5_155.xyz", delim = " ", col_names = F, skip = 9) %>% 
  select(2:4) %>% 
  arrange(X2)->myminexact

myminexact %>% 
  rename(x=1,y=2,z=3) %>% 
  mutate(CN=NULL)-> merdanmin
criteria_neighbor <- 3.2 #enough distance to capture all neighbors

for (i in 1:nrow(merdanmin)) {
  center_atom_x <- merdanmin$x[i]
  center_atom_y <- merdanmin$y[i]
  center_atom_z <- merdanmin$z[i]
  
  merdanmin %>% 
    filter( x>(center_atom_x-criteria_neighbor) & x<(center_atom_x+criteria_neighbor) &
              y>(center_atom_y-criteria_neighbor) & y<(center_atom_y+criteria_neighbor) &  
              z>(center_atom_z-criteria_neighbor) & z<(center_atom_z+criteria_neighbor) 
    ) %>% 
    nrow(.)-1 -> merdanmin$CN[i] #do -1 finally, because of self counting
}
  