function newsaving = function_merchant(saving, m, n)

newsaving = [];

for i = 1:length(n)
    saving = saving+(m/2);
    newsaving = [newsaving saving];
end