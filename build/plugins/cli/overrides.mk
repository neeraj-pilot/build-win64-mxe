$(PLUGIN_HEADER)

IS_HEIC_DECODE := $(true)
libheif_DEPS += libde265

vips_DEPS := $(filter-out librsvg pango,$(vips_DEPS)) libpng expat
vips_MESON_OPTS += -Dcplusplus=false -Dheif=enabled -Dpangocairo=disabled -Drsvg=disabled

define vips_BUILD
    $(eval export CFLAGS += -O3)
    $(eval export CXXFLAGS += -O3)

    $(MXE_MESON_WRAPPER) \
        --default-library=static \
        -Ddeprecated=false \
        -Dexamples=false \
        -Dintrospection=disabled \
        $(vips_MESON_OPTS) \
        '$(SOURCE_DIR)' \
        '$(BUILD_DIR)'

    $(MXE_NINJA) -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
