function J = median_filter(I, K)

[r,c] = size(I);
for i = 1 : r 
    for j = 1 : c 
        w = [];
        for x = (i - floor(K/2)) : (i + floor(K/2))
            for y = (j - floor(K/2)) : (j + floor(K/2))
            if(x >= 1 && x <= r) && (y >= 1 && y <= c)
                w(end + 1) = I(x,y);
            end
            end
        end
        w = median(w);
        I(i,j) = w;
    end

end
J = I;
