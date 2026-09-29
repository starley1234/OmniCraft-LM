$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 26 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 26;            // roller width
flange_d = 84;            // flange diameter
flange_t = 4;             // flange thickness
hub_d = 32.7;             // hub diameter

roller_profile = [[6.35, 0], [42, 0], [42, 4], [32, 4], [32.6, 13], [32, 22], [42, 22], [42, 26], [6.35, 26]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
