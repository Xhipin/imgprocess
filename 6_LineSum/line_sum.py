# -*- coding: utf-8 -*-
"""
Created on Sat Dec  5 17:30:57 2020

@author: User
"""
from matplotlib import image
from matplotlib import pyplot
import math
import numpy as np


def LineSum(img,p0,p1)->int:
    line=np.zeros_like(img); 
    
    if p1[0]-p0[0]!=0:# 0 ile bölmeden kurtulmak için konulan if-else
        m=(p1[1]-p0[1])/(p1[0]-p0[0]);
        n=p0[1]-m*p0[0];
        # Doğrunun eğimi ve 0 kesme noktası belirlendi.
        
    
        x_coord=np.linspace(p0[0],p1[0],abs(p1[0]-p0[0])+1);
        y_coord=m*x_coord+n;
        x_coord=x_coord.astype(int);
        y_coord=y_coord.astype(int);
        # m ve n değerlerinden doğru noktaları elde edildi.
    else:
         y_coord=np.linspace(p0[1],p1[1],abs(p1[1]-p0[1])+1);
         x_coord=p0[0]*np.ones_like(y_coord);
         x_coord=x_coord.astype(int);
         y_coord=y_coord.astype(int);   
        # Burada eğim olmadığından dolayı y coordinatlarının değişimine bakıldı.
        
    line[y_coord,x_coord]=1;
    line=np.multiply(line,img);
    # Doğrunun üzerindeki noktalara 1 değeri verildı ve eleman bazında çarpma
    #uygulandı.
    
    rgb_weights=[0.2990, 0.5870, 0.1140];
    
    line=np.dot(line[...,:3],rgb_weights); 
    # Beyaz değerler algılamak için gri skalada resim elde edildi.
    
    linesum=math.ceil(np.sum(line[np.where(line>0.99)])); 
    # Eşik değeri kullanılarak hesaplama hataları giderildi.
    # Pixel değeri 0.99'dan büyükse beyaz olarak algıla.
    
  
    return linesum;
    


img=image.imread('1.png');


p0=[300,200];
p1=[100,200];


linesum=LineSum(img,p0,p1);


