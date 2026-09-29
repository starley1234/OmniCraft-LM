$fn = 32;

// ----------------------------------------------------------------------
// Belt roller: 40 mm barrel, 42 mm wide, bore 7.94 mm
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_d = 7.94;            // bore
barrel_d = 40;            // barrel diameter
roller_w = 42;            // roller width
flange_d = 56;            // flange diameter
flange_t = 6;             // flange thickness
hub_d = 23.94;            // hub diameter

roller_profile = [[3.97, 0], [28, 0], [28, 6], [20, 6], [21.4, 21], [20, 36], [28, 36], [28, 42], [3.97, 42]];

/* the profile stays clear of the axis, so the bore comes out of the revolve */
rotate_extrude() polygon(roller_profile);
