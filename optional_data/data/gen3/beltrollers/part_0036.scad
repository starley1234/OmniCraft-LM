$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 48 mm barrel, 42 mm wide, bore 12.7 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 12.7;            // bore
barrel_d = 48;            // barrel diameter
roller_w = 42;            // roller width
flange_d = 64;            // flange diameter
flange_t = 6;             // flange thickness
hub_d = 36.7;             // hub diameter

roller_profile = [[6.35, 0], [32, 0], [32, 6], [24, 6], [25.4, 21], [24, 36], [32, 36], [32, 42], [6.35, 42]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
