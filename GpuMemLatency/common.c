#include "opencltest.h"

cl_device_id selected_device_id;
cl_platform_id selected_platform_id;
cl_ulong max_global_test_size;

// Fills an array using Sattolo's algo
void FillPatternArr(uint32_t* pattern_arr, uint32_t list_size, uint32_t byte_increment) {
    uint32_t increment = byte_increment / sizeof(uint32_t);
    uint32_t element_count = list_size / increment;
    for (int i = 0; i < element_count; i++) {
        pattern_arr[i * increment] = i * increment;
    }

    int iter = element_count;
    while (iter > 1) {
        iter -= 1;
        int j = iter - 1 == 0 ? 0 : rand() % (iter - 1);
        uint32_t tmp = pattern_arr[iter * increment];
        pattern_arr[iter * increment] = pattern_arr[j * increment];
        pattern_arr[j * increment] = tmp;
    }
}

cl_uint getCuCount() {
    cl_uint cuCount;
    size_t cuCountLen = sizeof(cl_uint);
    if (CL_SUCCESS != clGetDeviceInfo(selected_device_id, CL_DEVICE_MAX_COMPUTE_UNITS, cuCountLen, &cuCount, &cuCountLen))
    {
        fprintf(stderr, "Could not get number of compute units\n");
        return 0;
    }

    return cuCount;
}

size_t getMaxWorkgroupSize()
{
    size_t maxWorkgroupSize;
    size_t workgroupSizeLen = sizeof(size_t);
    if (CL_SUCCESS != clGetDeviceInfo(selected_device_id, CL_DEVICE_MAX_WORK_GROUP_SIZE, workgroupSizeLen, &maxWorkgroupSize, &workgroupSizeLen))
    {
        fprintf(stderr, "Could not get number of compute units\n");
        return 0;
    }

    return maxWorkgroupSize;
}

cl_ulong get_max_constant_buffer_size() {
    cl_ulong constant_buffer_size = 0;
    if (CL_SUCCESS != clGetDeviceInfo(selected_device_id, CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE, sizeof(cl_ulong), &constant_buffer_size, NULL)) {
        fprintf(stderr, "Failed to get max constant buffer size\n");
    }

    return constant_buffer_size;
}

cl_ulong get_max_buffer_size() {
    cl_ulong buffer_size = 0;
    if (CL_SUCCESS != clGetDeviceInfo(selected_device_id, CL_DEVICE_MAX_MEM_ALLOC_SIZE, sizeof(cl_ulong), &buffer_size, NULL)) {
        fprintf(stderr, "Failed to get max constant buffer size\n");
    }

    return buffer_size;
}

cl_ulong get_max_tex_buffer_size() {
    cl_ulong buffer_size = 0;
    if (CL_SUCCESS != clGetDeviceInfo(selected_device_id, CL_DEVICE_IMAGE_MAX_BUFFER_SIZE, sizeof(cl_ulong), &buffer_size, NULL)) {
        fprintf(stderr, "Failed to get max texture buffer size\n");
    }

    return buffer_size;
}

cl_ulong get_max_2d_tex_width() {
    cl_ulong max_width = 0;
    if (CL_SUCCESS != clGetDeviceInfo(selected_device_id, CL_DEVICE_IMAGE2D_MAX_WIDTH, sizeof(cl_ulong), &max_width, NULL)) {
        fprintf(stderr, "Failed to get max texture width\n");
    }

    return max_width;
}

cl_ulong get_max_2d_tex_height() {
    cl_ulong max_width = 0;
    if (CL_SUCCESS != clGetDeviceInfo(selected_device_id, CL_DEVICE_IMAGE2D_MAX_HEIGHT, sizeof(cl_ulong), &max_width, NULL)) {
        fprintf(stderr, "Failed to get max texture height\n");
    }

    return max_width;
}

short checkExtensionSupport(const char *extension_name) {
    size_t extensionLen = 0;
    char* extensions;
    if (CL_SUCCESS != clGetDeviceInfo(selected_device_id, CL_DEVICE_EXTENSIONS, 0, NULL, &extensionLen))
    {
        fprintf(stderr, "Could not determine memory needed to hold OpenCL extension list\n");
        return 0;
    }

    extensions = (char *)malloc(extensionLen + 1);
    extensions[extensionLen] = 0;
    if (CL_SUCCESS != clGetDeviceInfo(selected_device_id, CL_DEVICE_EXTENSIONS, extensionLen, extensions, &extensionLen))
    {
        fprintf(stderr, "Could not get OpenCL extensions list\n");
        return 0;
    }

    //fprintf(stderr, "OpenCL extensions list: %s\n", extensions);
    // extension list is space separated
    size_t spaceCount = 0;
    for (int i = 0; i < extensionLen; i++) {
        if (extensions[i] == ' ') spaceCount++;
    }

    int* extensionsSpaces = (int*)malloc(sizeof(int) * (spaceCount + 1));
    extensionsSpaces[0] = 0;
    int spaceIdx = 1;
    for (int i = 0; i < extensionLen; i++) {
        if (extensions[i] == ' ') {
            extensions[i] = 0;
            extensionsSpaces[spaceIdx] = i + 1;
            spaceIdx++;
        }
    }

    short found = 0;
    for (int i = 0; i < spaceCount; i++)
    {
        //fprintf(stderr, "Looking for %s = %s\n", extension_name, extensions + extensionsSpaces[i]);
        if (strcmp(extension_name, extensions + extensionsSpaces[i]) == 0) {
            found = 1;
            //fprintf(stderr, "found\n");
            break;
        }
    }

    free(extensionsSpaces);
    free(extensions);
    return found;
}

/// <summary>
/// populate global variables for opencl device id and platform id
/// </summary>
/// <param name="platform_index">platform index. if -1, prompt user</param>
/// <param name="device_index">device index. if -1. prompt user</param>
/// <returns>opencl context</returns>
cl_context get_context_from_user(int platform_index, int device_index) {
    int i = 0;
    int selected_platform_index = 0, selected_device_index = 0;

    // Get platform and device information
    cl_uint ret_num_devices;
    cl_uint ret_num_platforms;

    cl_int ret = clGetPlatformIDs(0, NULL, &ret_num_platforms);
    cl_platform_id* platforms = NULL;
    cl_device_id* devices = NULL;
    cl_context context = NULL;
    platforms = (cl_platform_id*)malloc(ret_num_platforms * sizeof(cl_platform_id));

    ret = clGetPlatformIDs(ret_num_platforms, platforms, NULL);
    fprintf(stderr, "clGetPlatformIDs returned %d. %d platforms\n", ret, ret_num_platforms);

    for (i = 0; i < ret_num_platforms; i++)
    {
        size_t platform_name_len;
        char* platform_name = NULL;
        if (CL_SUCCESS != clGetPlatformInfo(platforms[i], CL_PLATFORM_NAME, 0, NULL, &platform_name_len)) {
            fprintf(stderr, "Failed to get platform info for platform %d\n", i);
            continue;
        }

        platform_name = (char*)malloc(platform_name_len + 1);
        platform_name[platform_name_len] = 0;

        if (CL_SUCCESS != clGetPlatformInfo(platforms[i], CL_PLATFORM_NAME, platform_name_len, platform_name, NULL)) {
            fprintf(stderr, "Failed to get platform name for platform %d\n", i);
            free(platform_name);
            continue;
        }

        fprintf(stderr, "Platform %d: %s\n", i, platform_name);
        free(platform_name);
    }

    selected_platform_index = platform_index;
    if (selected_platform_index == -1)
    {
        printf("Enter platform #:");
        scanf("%d", &selected_platform_index);
    }

    if (selected_platform_index > ret_num_platforms - 1)
    {
        fprintf(stderr, "platform index out of range\n");
        goto get_context_from_user_end;
    }

    selected_platform_id = platforms[selected_platform_index];

    if (CL_SUCCESS != clGetDeviceIDs(selected_platform_id, CL_DEVICE_TYPE_ALL, 0, NULL, &ret_num_devices)) {
        fprintf(stderr, "Failed to enumerate device ids for platform");
        return NULL;
    }

    devices = (cl_device_id*)malloc(ret_num_devices * sizeof(cl_device_id));
    if (CL_SUCCESS != clGetDeviceIDs(selected_platform_id, CL_DEVICE_TYPE_ALL, ret_num_devices, devices, NULL)) {
        fprintf(stderr, "Failed to get device ids for platform");
        free(devices);
        return NULL;
    }

    fprintf(stderr, "clGetDeviceIDs returned %d devices\n", ret_num_devices);

    for (i = 0; i < ret_num_devices; i++)
    {
        size_t device_name_len;
        char* device_name = NULL;
        if (CL_SUCCESS != clGetDeviceInfo(devices[i], CL_DEVICE_NAME, 0, NULL, &device_name_len)) {
            fprintf(stderr, "Failed to get name length for device %d\n", i);
            continue;
        }

        //fprintf(stderr, "debug: device name length: %d\n", device_name_len);
        device_name = (char*)malloc(device_name_len + 1);
        device_name[device_name_len] = 0;

        if (CL_SUCCESS != clGetDeviceInfo(devices[i], CL_DEVICE_NAME, device_name_len, device_name, &device_name_len)) {
            fprintf(stderr, "Failed to get name for device %d\n", i);
            free(device_name);
            continue;
        }

        fprintf(stderr, "Device %d: %s\n", i, device_name);
        free(device_name);
    }

    selected_device_index = device_index;
    if (selected_device_index == -1)
    {
        fprintf(stderr, "Enter device #:");
        scanf("%d", &selected_device_index);
    }


    if (selected_device_index > ret_num_devices - 1)
    {
        fprintf(stderr, "Device index out of range\n");
        goto get_context_from_user_end;
    }

    selected_device_id = devices[selected_device_index];

    // Create an OpenCL context
    context = clCreateContext(NULL, 1, &selected_device_id, NULL, NULL, &ret);
    fprintf(stderr, "clCreateContext returned %d\n", ret);
    fprintf(stderr, "Max workgroup size for device: %u\n", getMaxWorkgroupSize());

get_context_from_user_end:
    free(platforms);
    free(devices);
    return context;
}

cl_program build_program(cl_context context, const char* fname)
{
    cl_int ret;
    FILE* fp = NULL;
    char* source_str;
    size_t source_size;
    fp = fopen(fname, "r");
    if (!fp) {
        fprintf(stderr, "Failed to load kernel %s.\n", fname);
        exit(1);
    }
    source_str = (char*)malloc(MAX_SOURCE_SIZE);
    source_size = fread(source_str, 1, MAX_SOURCE_SIZE, fp);
    fclose(fp);

    cl_program program = clCreateProgramWithSource(context, 1, (const char**)&source_str, (const size_t*)&source_size, &ret);
    ret = clBuildProgram(program, 1, &selected_device_id, NULL, NULL, NULL);
    //fprintf(stderr, "clBuildProgram %s returned %d\n", fname, ret);
    if (ret == -11)
    {
        size_t log_size;
        fprintf(stderr, "OpenCL kernel build error\n");
        clGetProgramBuildInfo(program, selected_device_id, CL_PROGRAM_BUILD_LOG, 0, NULL, &log_size);
        char* log = (char*)malloc(log_size);
        clGetProgramBuildInfo(program, selected_device_id, CL_PROGRAM_BUILD_LOG, log_size, log, NULL);
        fprintf(stderr, "%s\n", log);
        free(log);
    }

    free(source_str);
    return program;
}

void write_program(cl_program program)
{
    size_t* binarySizes = NULL;
    size_t nDevices = 0;
    cl_int ret, memoryRequired = 0;
    char fname[255];
    int i;
    unsigned char** binaries = NULL;

    ret = clGetProgramInfo(program, CL_PROGRAM_NUM_DEVICES, sizeof(size_t), &nDevices, NULL);
    if (ret != CL_SUCCESS) {
        fprintf(stderr, "Could not get number of devices for program\n");
        return;
    }

    fprintf(stderr, "Program is associated with %llu devices\n", nDevices);
    binarySizes = (size_t*)malloc(sizeof(size_t) * nDevices);
    if (binarySizes == NULL)
    {
        fprintf(stderr, "Failed to allocate memory for binary sizes\n");
        goto getProgram_Fail;
    }

    ret = clGetProgramInfo(program, CL_PROGRAM_BINARY_SIZES, sizeof(size_t) * nDevices, binarySizes, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Could not get program binary sizes\n");
        goto getProgram_Fail;
    }

    binaries = (unsigned char*)malloc(nDevices);
    for (i = 0; i < nDevices; i++) {
        fprintf(stderr, "Device %d: %llu byte program\n", i, binarySizes[i]);
        binaries[i] = (char*)malloc(binarySizes[i]);
    }

    ret = clGetProgramInfo(program, CL_PROGRAM_BINARIES, nDevices * sizeof(unsigned char*), binaries, NULL);
    if (ret != CL_SUCCESS)
    {
        fprintf(stderr, "Could not get program binaries\n");
        goto getProgram_Fail;
    }

    for (int i = 0; i < nDevices; i++)
    {
        snprintf(fname, 254, "prog%d", i);
        FILE* dst = fopen(fname, "w");
        fwrite(binaries[i], 1, binarySizes[i], dst);
        fclose(dst);
        fprintf(stderr, "Wrote compiled kernel to %s\n", fname);
    }

getProgram_Fail:
    for (int i = 0; i < nDevices; i++) free(binaries[i]);
    free(binaries);
    free(binarySizes);
}
