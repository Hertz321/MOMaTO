clear all
beep off
warning off
IGD = {};
rmp=0.3; % Random mating probability
gen = 1000;% Maximum Number of generations
pop = 5000;%population size
muc=20;
mum=20;
for index = 4%problem index
    Tasks=benchmark(index);
    for run=1:1%running times
        [IGD{run,index} , population{run,index}] =  MOMaTORP(Tasks,pop,gen,muc,mum,index);
    end
end

save('IGD','IGD');

