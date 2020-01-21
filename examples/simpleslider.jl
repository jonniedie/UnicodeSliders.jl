using UnicodeSliders: @manipulate
using UnicodePlots

a = @manipulate for i in 1:10, j in 3:3:30
    x = i + j
    t = collect(0.0:0.1:10.0)
    f(t) = x*t^2
    lineplot(f, t)
end
