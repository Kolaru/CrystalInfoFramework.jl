# Testing dictionary functionality

#==
@testset "Testing dictionary access and construction" begin
    @test begin
        t = DDLm_Dictionary(joinpath(@__DIR__,"ddl.dic"))
        true
    end
    @test begin
        t = DDLm_Dictionary(joinpath(@__DIR__,"ddl.dic"))
        String(t["_alias.deprecation_date"][:type][!,:source][]) == "Assigned"
    end
end

prepare_system() = begin
    t = DDLm_Dictionary(joinpath(@__DIR__,"cif_mag.dic"))
end

@testset "DDLm_Dictionaries" begin
    t = prepare_system()
    @test "_audit_conform.dict_name" in get_names_in_cat(t,"audit_conform")
    @test "_atom_site.label" in get_keys_for_cat(t,"atom_site")
end

@testset "Importation" begin
    ud = prepare_system()
    @test String(ud["_atom_site_rotation.label"][:name][!,:linked_item_id][]) == "_atom_site.label"
    # everything has a definition
    @test nrow(ud[:definition][ismissing.(ud[:definition].id),:]) == 0
end
==#
@testset "DDL2 dictionaries" begin
    t = DDL2_Dictionary(joinpath(@__DIR__,"ddl_core_2.1.3.dic"))
    @test find_category(t,"_sub_category_examples.case") == "sub_category_examples"
    @test haskey(t,"_category.mandatory_code")
    @test get_keys_for_cat(t,"sub_category") == ["_sub_category.id"]
    @test "_dictionary_history.update" in get_names_in_cat(t,"dictionary_history")
    @test "revision" in get_objs_in_cat(t,"dictionary_history")
end
