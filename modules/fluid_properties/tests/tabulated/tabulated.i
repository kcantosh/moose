# Test thermophysical property calculations using TabulatedFluidProperties.
# Calculations for density, internal energy and enthalpy using bicubic spline
# interpolation of data generated using CO2FluidProperties.

[Mesh]
  type = GeneratedMesh
  dim = 2
[]

[Variables]
  [./dummy]
  [../]
[]

[AuxVariables]
  [./pressure]
    initial_condition = 2e6
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./temperature]
    initial_condition = 350
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./rho]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./mu]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./e]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./h]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./s]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./cv]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./cp]
    family = MONOMIAL
    order = CONSTANT
  [../]
  [./c]
    family = MONOMIAL
    order = CONSTANT
  [../]
[]

[AuxKernels]
  [./rho]
    type = MaterialRealAux
    variable = rho
    property = density
  [../]
  [./my]
    type = MaterialRealAux
    variable = mu
    property = viscosity
  [../]
  [./internal_energy]
    type = MaterialRealAux
    variable = e
    property = e
  [../]
  [./enthalpy]
    type = MaterialRealAux
    variable = h
    property = h
  [../]
  [./entropy]
    type = MaterialRealAux
    variable = s
    property = s
  [../]
  [./cv]
    type = MaterialRealAux
    variable = cv
    property = cv
  [../]
  [./cp]
    type = MaterialRealAux
    variable = cp
    property = cp
  [../]
  [./c]
    type = MaterialRealAux
    variable = c
    property = c
  [../]
[]

[Modules]
  [./FluidProperties]
    [./co2]
      type = CO2FluidProperties
    [../]
    [./tabulated]
      type = TabulatedFluidProperties
      fp = co2
      fluid_property_file = fluid_properties.csv
    [../]
  []
[]

[Materials]
  [./fp_mat]
    type = FluidPropertiesMaterialPT
    pressure = pressure
    temperature = temperature
    fp = tabulated
  [../]
[]

[Kernels]
  [./diff]
    type = Diffusion
    variable = dummy
  [../]
[]

[Executioner]
  type = Steady
  solve_type = NEWTON
[]

[Postprocessors]
  [./rho]
    type = ElementalVariableValue
    elementid = 0
    variable = rho
  [../]
  [./mu]
    type = ElementalVariableValue
    elementid = 0
    variable = mu
  [../]
  [./e]
    type = ElementalVariableValue
    elementid = 0
    variable = e
  [../]
  [./h]
    type = ElementalVariableValue
    elementid = 0
    variable = h
  [../]
  [./s]
    type = ElementalVariableValue
    elementid = 0
    variable = s
  [../]
  [./cv]
    type = ElementalVariableValue
    elementid = 0
    variable = cv
  [../]
  [./cp]
    type = ElementalVariableValue
    elementid = 0
    variable = cp
  [../]
  [./c]
    type = ElementalVariableValue
    elementid = 0
    variable = c
  [../]
[]

[Outputs]
  csv = true
  file_base = tabulated_out
  execute_on = 'TIMESTEP_END'
  print_perf_log = true
[]
