%Process sound files (squish them
clear
close all

dir_name = 'C:\Users\Brian\Google Drive\QMB\Sound files\';
flist = ls([dir_name 'spoken*.wav']);
for ii = 1:size(flist,1)
    [y,fs] = audioread([dir_name flist(ii,:)]);
    suffix = deblank(flist(ii,7:end));
    audiowrite([dir_name 'word' suffix],y/1e3,fs,'BitsPerSample',32)
end