module UnicodeSliders

# using UnicodePlots

export @manipulate

macro manipulate(args...)
    @assert length(args) == 1 # TODO: add error message

    for_block = args[1]
    @assert for_block.head == :for # TODO: add error message

    loop_vars = get_loop_vars(Val(for_block.args[1].head), for_block.args[1].args)
    var_exprs = init_loop_var.(loop_vars)

    pushfirst!(for_block.args[2].args, var_exprs...)

    # Clear console screen
    println("\33[2J")


    return for_block.args[2]
end



head_val(expr::Expr) = Val(expr.head)
args(expr::Expr) = expr.args

get_loop_vars(::Val{:block}, expr) = vcat(get_loop_vars.(head_val.(expr), args.(expr)))
get_loop_vars(::Val{:(=)}, expr) = (name=expr[1], range=eval(expr[2]))

init_loop_var(loop_var::NamedTuple{(:name, :range)}) =
    Expr(:(=), loop_var.name, loop_var.range[1])

# run_loop(loop)

end # module
