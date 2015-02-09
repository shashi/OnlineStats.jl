using OnlineStats
using Base.Test

# Quaniles not tested (yet) due to stochastic nature

#------------------------------------------------------------------------------#
#                                                 Simulate two batches of data #
#------------------------------------------------------------------------------#
srand(1234)
n1 = 246
n2 = 978
x1 = rand(n1)
x2 = rand(n2)
x = [x1, x2]

#------------------------------------------------------------------------------#
#                                                    Batch 1 estimate correct? #
#------------------------------------------------------------------------------#

ob = online_summary(x1)
@test ob.mean[1] == mean(x1)
@test ob.var[1] == var(x1)
@test ob.max[1] == maximum(x1)
@test ob.min[1] == minimum(x1)
@test ob.quantile.est == quantile(x1, [.25, .5, .75])'

#------------------------------------------------------------------------------#
#                                        Batch 2 estimate correct? - row added #
#------------------------------------------------------------------------------#

update!(ob, x2, true)
@test ob.mean[end] == mean(x)
@test ob.var[end] == var(x)
@test ob.max[end] == maximum(x)
@test ob.min[end] == minimum(x)


#------------------------------------------------------------------------------#
#                                     Batch 2 estimate correct? - row replaced #
#------------------------------------------------------------------------------#
ob = online_summary(x1)
update!(ob, x2, false)
@test ob.mean[1] == mean(x)
@test ob.var[1] == var(x)
@test ob.max[1] == maximum(x)
@test ob.min[1] == minimum(x)
