!==============================================================================!
  subroutine Load_Physical_Properties(grid)
!------------------------------------------------------------------------------!
!   Reads physical properties from control file.                               !
!------------------------------------------------------------------------------!
!----------------------------------[Modules]-----------------------------------!
  use Grid_Mod
  use Field_Mod
  use Control_Mod
  use Turb_Mod
!------------------------------------------------------------------------------!
  implicit none
!---------------------------------[Arguments]----------------------------------!
  type(Grid_Type) :: grid
  real            :: dens_const, visc_const

!==============================================================================!

  !Allocate Properties:
  allocate(density(-grid % n_bnd_cells:grid % n_cells))
  allocate(viscosity(-grid % n_bnd_cells:grid % n_cells))

  call Control_Mod_Dynamic_Viscosity    (visc_const) 
  call Control_Mod_Mass_Density         (dens_const)
  call Control_Mod_Heat_Capacity        (capacity)
  call Control_Mod_Thermal_Conductivity (conductivity)
  call Control_Mod_Species_Diffusivity  (diffusivity)

  if (multiphase) then
    call Control_Mod_Multiphase_Density   (density_mult)
    call Control_Mod_Multiphase_Viscosity (viscosity_mult)
    call Control_Mod_Surface_Tension      (surface_tension)
  else
    density(:)   = dens_const
    dens_face(:) = dens_const
    viscosity(:) = visc_const
  end if

  end subroutine
