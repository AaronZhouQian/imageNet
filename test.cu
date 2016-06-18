__global__ void add(int *a, int *b , int *result)
{
    *result= *a + *b;   
}

int main()
{
    int a,b,result;
    int *device_a,*device_b,*device_result;
    int size=sizeof(int);
    
    cudaMalloc((void **)&device_a,size);
    cudaMalloc((void **)&device_b,size);
    cudaMalloc((void **)&device_result,size);
    
    a=2;
    b=7;
    
    cudaMemcpy(device_a,&a,size,cudaMemcpyHostToDevice);
    cudaMemcpy(device_b,&b,size,cudaMemcpyHostToDevice);
    
    add<<<1,1>>>(device_a,device_b,device_result);
    
    cudaMemcpy(&result,device_result,size,cudaMemcpyDeviceToHost);
    
    cudaFree(device_a);
    cudaFree(device_b);
    cudaFree(device_result);
    return 0;
}