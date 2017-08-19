function [ RRMSE ] = shredRRMSE( GT,Rec )
%SHREDRRMSE Summary of this function goes here
%   Detailed explanation goes here

err_map  = sqrt((GT(:)-Rec(:)).^2);
rel_err  = err_map(:)./GT(:);
RRMSE = mean(rel_err);
end

