function [ acceptRatio ] = GetAcceptRatio( acceptArray, evaluateInterval )
%Get the accept ratio if evaluate whether to accept or not in
%evaluateInterval times

    totalEvaluateTimes=length(acceptArray);
    index=1;
    count=0;
    acceptTimesOfInterval=0;
    
    for i=1:totalEvaluateTimes
        count=count+1;
        if acceptArray(i)==1
            acceptTimesOfInterval=acceptTimesOfInterval+1;
        end
        if count==evaluateInterval
            acceptRatio(index)=acceptTimesOfInterval/evaluateInterval;
            index=index+1;
            count=0;
            acceptTimesOfInterval=0;
        end      
    end
end

