$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 64 mm barrel, 42 mm wide, bore 9.52 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 9.52;            // bore
barrel_d = 64;            // barrel diameter
roller_w = 42;            // roller width
flange_d = 80;            // flange diameter
flange_t = 6;             // flange thickness
hub_d = 25.52;            // hub diameter

roller_profile = [[4.76, 0], [40, 0], [40, 6], [32, 6], [33, 21], [32, 36], [40, 36], [40, 42], [4.76, 42]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
