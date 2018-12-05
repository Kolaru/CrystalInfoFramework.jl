# Data access tests

# Simple value tests
@testset "Simple data values" begin
    b = prepare_block("simple_data.cif","simple_data")
    @test b["_numb_su"] == ["0.0625(2)"]
    @test b["_unquoted_string"] == ["unquoted"]
    @test b["_text_string"] == ["text"]
    known_dnames =  Set(["_unknown_value",
"_na_value",
"_unquoted_string",
"_sq_string",      
"_dq_string",      
"_text_string",
"_numb_plain",    
"_numb_su",          
"_numb_tz",          
"_numb_quoted",      
"_query_quoted",     
"_dot_quoted"])       

    set_diff = setdiff(known_dnames, Set(keys(b)))
    println("Difference: $set_diff")
    @test length(set_diff) == 0
end

# Looped value tests
@testset "Looped values" begin
    b = prepare_block("simple_loops.cif","simple_loops")
    l = get_loop(b,"_col2")
    vals = []
    for p in eachrow(l)
      push!(vals,String(p[:_col2]))
    end
    @test Set(vals) == Set(["v1","v2","v3"])
    # do it again as this has failed in the past
    m = get_loop(b,"_scalar_a")
    vals = []
    for p in eachrow(l)
        println("Do nothing")
        push!(vals,String(p[:_col2]))
    end
    @test Set(vals) == Set(["v1","v2","v3"])
    vals = []
    for q in eachrow(m)
        push!(vals,String(q[:_scalar_a]))
    end
    @test vals == ["a"]
end

# Test lists
@testset "List values" begin
    b = prepare_block("list_data.cif","list_data")
    l = b["_digit_list"]
    println("digit list is $l")
    r = collect(l)
    @test r == ["0","1","2","3","4","5","6","7","8","9"]
end

# Test tables
@testset "Table values" begin
b = prepare_block("table_data.cif","table_data")
l = b["_type_examples"]
@test l["numb"]=="-123.4e+67"
@test l["char"]=="char"
@test "unknown" in keys(l)
end
