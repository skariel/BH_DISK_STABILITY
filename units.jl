# velocity is in Kms/s
# length is Mpc/h
# mass is 1e10 Ms/h
const G = 43007.1

const GAMMA = 5/3
const GAMMA_MINUS1 = GAMMA - 1
const HYDROGEN_MASSFRAC = 0.76

# in cgs:

const BOLTZMANN = 1.3806e-16
const PROTONMASS = 1.6726e-24

const UnitMass_in_g = 1.989e43
const UnitVelocity_in_cm_per_s = 1.0e5
const UnitEnergy_in_cgs = UnitMass_in_g * UnitVelocity_in_cm_per_s^2;

function calc_Temp(entropy, density) {
    u = entropy/(GAMMA_MINUS1)*density^GAMMA_MINUS1;
    MW = 4.0/(8.0-5.0*(1.0-HYDROGEN_MASSFRAC));
    u*(GAMMA_MINUS1)/BOLTZMANN*PROTONMASS*MW*
                        UnitEnergy_in_cgs/UnitMass_in_g;
}