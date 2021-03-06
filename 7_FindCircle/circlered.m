function circlered(file)
%% 
% file: String tipinde verilmek istenen görüntü

img=imread(file);
laplacian=[-1 -1 0; -1 5 -1; 0 -1 0]; 

% Laplacian matrisi kenar tanıma
% işleminde yuvarlağın uzunluğunun gerçek uzunluğuna yakın olması için 
% değiştirildi. Not: Bu Dataset için geçerlidir.

img=rgb2gray(img);
img_size=size(img);

edges=imfilter(img,laplacian);
edges(1,:)=0;
edges(:,1)=0;
edges(img_size(1),:)=0;
edges(:,img_size(2))=0; 
% Kenar tanıma için Laplacian filtresi uygulandı.
% Algoritma kenarlarda yuvarlağın sınırı olmadığı sürece çalışacaktır

sum_edges=sum(sum(edges))/255;
% Toplam açık pixel sayısı bu kodla belirlendi.

r_first=0;
r_last=0;
ff=0;
fl=0;
for i=1:img_size(1)
    condi=sum(edges(i,:)>128);
    condimg=sum(edges(img_size(1)-i+1,:)>128);
    if ff==0 && condi>0
        r_first= i;
        ff=1;
    end
    
    if fl==0 && condimg>0
        r_last=(img_size(1)-i+1)*(condimg>0)+r_last;
        fl=1;
    end
    
    if ff && fl
        break;
    end
end
% Daire simetrik bir şekil olduğu için tek yönden bakılarak çap hesaplandı.
r=(r_last-r_first)/2;
circ=round(2*pi*r);

% sum_edges çemberin çevresiyle kıyaslandı.

threshold=10;

found=(abs(sum_edges-circ)<threshold);
% Aralarındaki fark eşik değerinden küçükse bulundu farzet.

redcircle=zeros([img_size 3]);

if found==1
    
    redcircle(:,:,1)=255;
    redcircle(:,:,2)=img;
    redcircle(:,:,3)=img;
    redcircle=uint8(redcircle);
    imwrite(redcircle,'redcircle.png');
end
% Bulunmuşsa renk değiştirme işlemini gerçekleştir ve çıktı olarak ver.


end