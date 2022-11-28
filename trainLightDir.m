function net = trainLightDir(xTrain, yTrain, xValidation, yValidation)
    layers = [
        imageInputLayer([512 612 3])
        convolution2dLayer(3,8,'Padding','same')
        batchNormalizationLayer
        reluLayer
        averagePooling2dLayer(2,'Stride',2)
        convolution2dLayer(3,16,'Padding','same')
        batchNormalizationLayer
        reluLayer
        averagePooling2dLayer(2,'Stride',2)
        convolution2dLayer(3,32,'Padding','same')
        batchNormalizationLayer
        reluLayer
        averagePooling2dLayer(2,'Stride',2)
        convolution2dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
        averagePooling2dLayer(2,'Stride',2)
        convolution2dLayer(3,128,'Padding','same')
        batchNormalizationLayer
        reluLayer
        averagePooling2dLayer(2,'Stride',2)
        convolution2dLayer(3,256,'Padding','same')
        batchNormalizationLayer
        reluLayer
        averagePooling2dLayer(2,'Stride',2)
        convolution2dLayer(3,512,'Padding','same')
        batchNormalizationLayer
        reluLayer
        averagePooling2dLayer(2,'Stride',2)
        convolution2dLayer(3,1028,'Padding','same')
        batchNormalizationLayer
        reluLayer
        dropoutLayer(0.2)
        fullyConnectedLayer(3)
        layerNormalizationLayer
        regressionLayer];
    
    miniBatchSize  = 128;
    validationFrequency = floor(numel(yTrain)/miniBatchSize);
    options = trainingOptions('sgdm', ...
        'MiniBatchSize',miniBatchSize, ...
        'MaxEpochs',30, ...
        'InitialLearnRate',1e-3, ...
        'LearnRateSchedule','piecewise', ...
        'LearnRateDropFactor',0.1, ...
        'LearnRateDropPeriod',20, ...
        'Shuffle','every-epoch', ...
        'ValidationData',{xValidation,yValidation}, ...
        'ValidationFrequency',validationFrequency, ...
        'Plots','training-progress', ...
        'Verbose',false);
    
    net = trainNetwork(xTrain,yTrain,layers,options);
end