@reexport module Model

using ProgressMeter: @showprogress
using Serialization

using ..MetaLanguage
using ..Task
using ..TheoremProving

"Abstract type for models."
abstract type AbstractModel end

"""
    predict(model::AbstractModel, example::Example)::Prediction

Return the prediction of `model` on `example`.

See also: [`Prediction`](@ref).
"""
function predict(::AbstractModel, ::Example)::Vector{Prediction}
    error("Not implemented")
end

"""
    predict(model::AbstractModel, ds::Dataset)::Vector{Prediction}

Return the predictions of `model` on the entire dataset `ds`.

See also: [`Prediction`](@ref).
"""
function predict(model::AbstractModel, ds::Dataset)::Vector{Vector{Prediction}}
    @info "Predicting on $(length(ds)) examples.."
    serialize("model.bin", model)
    serialize("ds.bin", ds)
    return @showprogress [predict(model, ex) for ex in ds]
end

include("trivial_models.jl")
include("reasoning_model.jl")

export predict

end