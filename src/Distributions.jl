
using .Distributions # Requires.jl replace usual syntax with this

# Define recipe for 2d MvNormal

@recipe function f(dist::MvNormal, alpha=0.0001)
    seriestype --> :contours
    x_mdist = Normal(dist.μ[1], sqrt(dist.Σ[1,1]))
    y_mdist = Normal(dist.μ[2], sqrt(dist.Σ[2,2]))
    xmin, xmax = quantile.(x_mdist, [alpha, 1-alpha])
    ymin, ymax = quantile.(y_mdist, [alpha, 1-alpha])
    (range(xmin, xmax, length=100), range(ymin, ymax, length=100), (x,y)->pdf(dist, [x,y]))
end

function find_limit(mdist_list, prior_p, alpha)
    q_l = [quantile(mdist, alpha) for mdist in mdist_list]
    l = minimum(q_l)
    r = maximum(q_l)
    
    for i in 1:100
        s = (l+r)/2
        sum_cdf = sum([cdf(mdist, s) * p for (mdist, p) in zip(mdist_list, prior_p)])
        if sum_cdf < alpha
            l = s
        else
            r = s
        end
    end
    
    left = (l + r) / 2
end

function find_limit2(mdist_list, prior_p, alpha)
    find_limit(mdist_list, prior_p, alpha), find_limit(mdist_list, prior_p, 1-alpha)
end

@recipe function f(mix_dist::MixtureModel{Multivariate, Continuous, <:MvNormal}, alpha=0.0001)
    seriestype --> :contours
    
    x_mdist_list = [Normal(comp.μ[1], sqrt(comp.Σ[1,1])) for comp in mix_dist.components]
    y_mdist_list = [Normal(comp.μ[2], sqrt(comp.Σ[2,2])) for comp in mix_dist.components]
    
    prior_p = mix_dist.prior.p
    
    xmin, xmax = find_limit2(x_mdist_list, prior_p, alpha)
    ymin, ymax = find_limit2(y_mdist_list, prior_p, alpha)
    
    (range(xmin, xmax, length=100), range(ymin, ymax, length=100), (x,y)->pdf(mix_dist, [x,y]))
end
