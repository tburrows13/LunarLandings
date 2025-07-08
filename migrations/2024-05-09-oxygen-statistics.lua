for _, diffuser_list in pairs(storage.oxygen_diffusers.list) do
  for _, diffuser_data in pairs(diffuser_list) do
    diffuser_data.fluid_production_statistics = diffuser_data.entity.force.get_fluid_production_statistics(diffuser_data.entity.surface)
  end
end