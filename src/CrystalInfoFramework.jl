#==

    Copyright Australian Nuclear Science and Technology Organisation 2019-2021

    CrystalInfoFramework.jl is free software: you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see
    <https://www.gnu.org/licenses/>.

==#

module CrystalInfoFramework
using DataFrames
using URIs
using Lerche # for native parser
using cif_api_jll # for cif API parser
using PrecompileTools #for fast startup

# **Exports**

export CifValue,Cif,Block,CifBlock
export cif_from_string
export CifContainer, NestedCifContainer
export get_frames,get_contents
export get_loop, eachrow, add_to_loop!, create_loop!

# Base methods that we add to
import Base:keys,getindex,setindex!,length,haskey,iterate,get
import Base:delete!,show,first

# *Crystallographic Information Framework*
#
# See iucr.org for specifications.
#
# This package provides methods for reading and writing
# CIF files. A subpackage provides a data API that
# allows any file to be interpreted according to the
# CIF relational model.  This is used by CIF_dREL
# (a separate package) to execute dREL code on any
# dataset.
#
include("cif_errors.jl")
include("libcifapi.jl")
include("cif_base.jl")
include("cif2_transformer.jl")
include("cif_dic.jl")
include("caseless_strings.jl")
include("ddlm_dictionary_ng.jl")
include("ddl2_dictionary_ng.jl")
include("data_with_dictionary.jl")
include("merge_blocks.jl")
include("cif_output.jl")

"""
module DataContainer defines simple and complex
collections of tables (relations) for use with
CIF dictionaries.
"""
module DataContainer

using ..CrystalInfoFramework
using DataFrames
using MacroTools

import Base: haskey,getindex,keys,show,iterate,length
import Base: isless

include("DataContainer/Types.jl")
include("DataContainer/DataSource.jl")
include("DataContainer/Relations.jl")
end

#
@compile_workload begin
    c = Cif(joinpath(@__DIR__, "../test/nick1.cif"), native=true)
    d = DDLm_Dictionary(joinpath(@__DIR__, "../test/ddl.dic"), ignore_imports=true)
end

end
