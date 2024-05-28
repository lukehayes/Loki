package loki

import "core:fmt"
import "core:mem"


report_memory_leaks :: proc(alctr: ^mem.Tracking_Allocator) -> bool
{
    memory_leak := false

    fmt.println("---------------")
    for key, val in alctr.allocation_map
    {
	fmt.println("")
	fmt.printf("*x*x*x*x* ==> %v: Memory Leak: %v bytes \n", val.location, val.size)
	fmt.println("")
	memory_leak = true
    }

    if !memory_leak {
	fmt.println(" ")
	fmt.println("No memory leaks found.")
	fmt.println(" ")
    }

    fmt.println("---------------")

    mem.tracking_allocator_clear(alctr)

    return memory_leak
}

