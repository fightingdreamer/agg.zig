const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const c_flags = [_][]const u8{
        "-std=c++03",
    };

    const upstream = b.dependency("upstream", .{});
    const src_path = upstream.path("agg-src/src");
    const include_path = upstream.path("agg-src/include");

    // -------------------------------------------------------------------------

    const lib_agg = b.addStaticLibrary(.{
        .name = "agg",
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(lib_agg);

    lib_agg.addIncludePath(include_path);
    lib_agg.addCSourceFiles(.{
        .root = src_path,
        .flags = &c_flags,
        .files = &.{
            "agg_arc.cpp",
            "agg_arrowhead.cpp",
            "agg_bezier_arc.cpp",
            "agg_bspline.cpp",
            "agg_color_rgba.cpp",
            "agg_curves.cpp",
            "agg_embedded_raster_fonts.cpp",
            "agg_gsv_text.cpp",
            "agg_image_filters.cpp",
            "agg_line_aa_basics.cpp",
            "agg_line_profile_aa.cpp",
            "agg_rounded_rect.cpp",
            "agg_sqrt_tables.cpp",
            "agg_trans_affine.cpp",
            "agg_trans_double_path.cpp",
            "agg_trans_single_path.cpp",
            "agg_trans_warp_magnifier.cpp",
            "agg_vcgen_bspline.cpp",
            "agg_vcgen_contour.cpp",
            "agg_vcgen_dash.cpp",
            "agg_vcgen_markers_term.cpp",
            "agg_vcgen_smooth_poly1.cpp",
            "agg_vcgen_stroke.cpp",
            "agg_vpgen_clip_polygon.cpp",
            "agg_vpgen_clip_polyline.cpp",
            "agg_vpgen_segmentator.cpp",
            "ctrl/agg_bezier_ctrl.cpp",
            "ctrl/agg_cbox_ctrl.cpp",
            "ctrl/agg_gamma_ctrl.cpp",
            "ctrl/agg_gamma_spline.cpp",
            "ctrl/agg_polygon_ctrl.cpp",
            "ctrl/agg_rbox_ctrl.cpp",
            "ctrl/agg_scale_ctrl.cpp",
            "ctrl/agg_slider_ctrl.cpp",
            "ctrl/agg_spline_ctrl.cpp",
        },
    });
    lib_agg.linkLibCpp();
    lib_agg.installHeadersDirectory(include_path, "", .{});
    lib_agg.installHeadersDirectory(src_path, "", .{});
}
