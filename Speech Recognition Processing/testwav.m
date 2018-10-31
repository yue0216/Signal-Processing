file_path = '/Users/Ousyoukan/Documents/recording';
num_of_waves_per_week = 6;
num_of_group = 15;
GMM_com = 16;
%%feature%%
all_of_train_feature = [];
%%score%%
score = zeros(num_of_group,1);
all_of_score_nor= zeros(num_of_waves_per_week,num_of_group);
all_of_score_slow= zeros(num_of_waves_per_week,num_of_group);
all_of_score_fast= zeros(num_of_waves_per_week,num_of_group);

%%train file%%
for i = 1:num_of_waves_per_week
   sample_file = [file_path '/sample/' num2str(i) '2.wav'];
   [data, fs] = readwav(sample_file);
   train_feature = melcepst(data, fs);
   all_of_train_feature = [all_of_train_feature;train_feature];
end

[mu_model, sigma_model, weight_model] = gmm_estimate(all_of_train_feature', GMM_com);

for i = 1:num_of_group
    for j = 1:num_of_waves_per_week
        test_file = [file_path '/W' num2str(i) 'S' num2str(j) 'M1.wav'];
        
        [Data, fs] = readwav(test_file);
        test_feature = melcepst(Data, fs);
        [lYM, lY] = lmultigauss(test_feature', mu_model, sigma_model, weight_model);
        score(i) = mean(lY);
        all_of_score_nor(j,i) = score(i);
        fprintf('W%dS%dM1.wav\t%f\n', i, j, score(i));
    end
    
    for j = 1:num_of_waves_per_week
        test_file = [file_path '/W' num2str(i) 'S' num2str(j) 'M2.wav'];
    
        
        [Data, fs] = readwav(test_file);
        test_feature = melcepst(Data, fs);
        [lYM, lY] = lmultigauss(test_feature', mu_model, sigma_model, weight_model);
        score(i) = mean(lY);
        all_of_score_fast(j,i) = score(i);
        fprintf('W%dS%dM2.wav\t%f\n', i, j, score(i));
    end
    
    for j = 1:num_of_waves_per_week
        test_file = [file_path '/W' num2str(i) 'S' num2str(j) 'M3.wav'];
        
        [Data, fs] = readwav(test_file);
        test_feature = melcepst(Data, fs);
        [lYM, lY] = lmultigauss(test_feature', mu_model, sigma_model, weight_model);
        score(i) = mean(lY);
        all_of_score_slow(j,i) = score(i);
        fprintf('W%dS%dM3.wav\t%f\n', i, j, score(i));
    end
end
